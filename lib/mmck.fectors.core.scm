;;; -*- coding: utf-8-unix  -*-
;;;
;;;Part of: MMCK Template
;;;Contents: functional vectors implementation
;;;Date: Apr 24, 2019
;;;
;;;Abstract
;;;
;;;	This unit is the core module.
;;;
;;;Author: Ian Price <ianprice90@googlemail.com>
;;;Ported to CHICKEN by: Marco Maggi <mrc.mgg@gmail.com>
;;;
;;;Copyright (C) 2019 Marco Maggi <mrc.mgg@gmail.com>
;;;Copyright (C) 2012 Ian Price <ianprice90@googlemail.com>
;;;All rights reserved.
;;;
;;;Redistribution and use  in source and binary forms, with  or without modification,
;;;are permitted provided that the following conditions are met:
;;;
;;;1. Redistributions  of source code  must retain  the above copyright  notice, this
;;;   list of conditions and the following disclaimer.
;;;
;;;2. Redistributions in binary form must  reproduce the above copyright notice, this
;;;   list of  conditions and  the following disclaimer  in the  documentation and/or
;;;   other materials provided with the distribution.
;;;
;;;3. The name of  the author may not be used to endorse  or promote products derived
;;;   from this software without specific prior written permission.
;;;
;;;THIS SOFTWARE  IS PROVIDED  BY THE  AUTHOR ``AS  IS'' AND  ANY EXPRESS  OR IMPLIED
;;;WARRANTIES,   INCLUDING,  BUT   NOT  LIMITED   TO,  THE   IMPLIED  WARRANTIES   OF
;;;MERCHANTABILITY AND FITNESS FOR A PARTICULAR  PURPOSE ARE DISCLAIMED.  IN NO EVENT
;;;SHALL  THE  AUTHOR  BE  LIABLE  FOR ANY  DIRECT,  INDIRECT,  INCIDENTAL,  SPECIAL,
;;;EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;;SUBSTITUTE  GOODS  OR  SERVICES;  LOSS  OF USE,  DATA,  OR  PROFITS;  OR  BUSINESS
;;;INTERRUPTION) HOWEVER CAUSED AND ON ANY  THEORY OF LIABILITY, WHETHER IN CONTRACT,
;;;STRICT LIABILITY, OR  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING  IN ANY WAY
;;;OUT  OF THE  USE OF  THIS SOFTWARE,  EVEN IF  ADVISED OF  THE POSSIBILITY  OF SUCH
;;;DAMAGE.


;;;; documentation
;;
;; make-fector :: Int [ Object ] -> Fector
;; Returns a fector of a specified size. If the fill parameter is
;; given, the locations of the fector are initialised to that object,
;; otherwise their initial values are unspecified.
;;
;; fector :: [Object ...] -> Fector
;; Returns a fector whose initial values are given as arguments.
;;
;; fector? :: Object -> Boolean
;; Returns #t if a given object is a fector, #f otherwise.
;;
;; fector-length :: Fector -> Int
;; Returns the number of elements that are stored in the fector.
;;
;; build-fector :: Int (Int -> Object) -> Fector
;; returns a new fector of a given length, where each element is
;; initialised to the value of the given function applied to its index.
;;
;; fector-ref :: Fector Int -> Object
;; Returns the value associated with a given index into the fector. If
;; the index is outwith the range 0 <= index < length, then an
;; &assertion is raised.
;;
;; fector-set :: Fector Int Object -> Fector
;; Returns a new fector equivalent to the previous one except the
;; given index is now associated with a given object. If the index is
;; outwith the range 0 <= index < length, then an &assertion is
;; raised.
;;
;; list->fector ;; Listof(Object) -> Fector
;; Returns a fector initialised with the contents of the given list.
;;
;; fector->list :: Fector -> Listof(Object)
;; Returns a list containing the objects in a given fector.
;;


;;;; units and module header

(declare (unit mmck.fectors.core)
	 (emit-import-library mmck.fectors.core))

(require-library (coops)
		 (coops-primitive-objects))

(module (mmck.fectors.core)
    (make-fector
     fector
     fector?
     fector-length
     build-fector
     fector-ref
     fector-set
     list->fector
     fector->list
     fector=?)
  (import (scheme)
	  (only (chicken base)
		unless
		assert
		case-lambda)
	  (coops)
	  (coops-primitive-objects))


;;;; utilities

(define (build-vector n f)
  (assert (>= n 0))
  (let ((v (make-vector n)))
    (define (populate! i)
      (unless (= i n)
        (vector-set! v i (f i))
        (populate! (+ i 1))))
    (populate! 0)
    v))


;;;; main

(define-class <fector> ()
  ((value reader: fector-value writer: fector-value-set!)))

(define-syntax is-a?
  (syntax-rules ()
    ((_ ?obj ?class)
     (eq? ?class (class-of ?obj)))))

(define (fector? obj)
  (is-a? obj <fector>))

;;; --------------------------------------------------------------------

(define-class <diff> ()
  ((index  reader: diff-index)
   (value  reader: diff-value  writer: diff-value-set!)
   (parent reader: diff-parent writer: diff-parent-set!)))

(define (diff? obj)
  (is-a? obj <diff>))

(define-method (make-diff (index <integer>) (value #t) (parent-fector <fector>))
  (make <diff> 'index index 'value value 'parent parent-fector))

;;; --------------------------------------------------------------------

(define make-fector
  (case-lambda
   ((n)
    (make <fector> 'value (make-vector n)))
   ((n fill)
    (make <fector> 'value (make-vector n fill)))))

(define (fector . args)
  (make <fector> 'value (apply vector args)))

(define-method (build-fector (n <integer>) (fill #t))
  (make <fector> 'value (build-vector n fill)))


(define-method (fector-length (fector <fector>))
  (reroot! fector)
  (vector-length (fector-value fector)))

(define-method (fector-ref (fector <fector>) (index <integer>))
  (reroot! fector)
  (let ((vector (fector-value fector)))
    (assert (and (<= 0 index)
                 (< index (vector-length vector))))
    (vector-ref vector index)))

(define-method (fector-set (fector <fector>) (index <integer>) (object #t))
  (reroot! fector)
  (let ((v (fector-value fector)))
    (assert (and (<= 0 index)
                 (< index (vector-length v))))
    (let ((old-value (vector-ref v index)))
      (vector-set! v index object)
      (let* ((new-fector (make <fector> 'value v))
             (diff (make-diff index old-value new-fector)))
        (fector-value-set! fector diff)
        new-fector))))

(define-method (reroot! (fector <fector>))
  (define value (fector-value fector))
  (if (diff? value)
      (let* ((index (diff-index value))
             (parent (reroot! (diff-parent value)))
             (parent-vector  (fector-value parent))
             ;; currently make new diff -- should reuse existing
             (diff (make-diff index (vector-ref parent-vector index) fector)))
        (vector-set! parent-vector index (diff-value value))
        (fector-value-set! fector parent-vector)
        (fector-value-set! parent diff)
        fector)
    fector))


;;;; conversion

(define-method (list->fector (ell <list>))
  (make <fector> 'value (list->vector ell)))

(define-method (fector->list (fector <fector>))
  (reroot! fector)
  (vector->list (fector-value fector)))


;;;; comparison

(define fector=?
  (case-lambda
   ((obj1 obj2)
    (fector=?-2 obj1 obj2))
   ((obj1 obj2 item=)
    (fector=?-3 obj1 obj2 item=))))

(define-method (fector=?-2 (obj1 <fector>) (obj2 <fector>))
  (fector=?-3 obj1 obj2 eqv?))

(define-method (fector=?-3 (obj1 <fector>) (obj2 <fector>) (item= <procedure>))
  (or (eq? obj1 obj2)
      (let ((len1 (fector-length obj1)))
	(and (= len1 (fector-length obj2))
	     (let loop ((i 0))
	       (or (= i len1)
		   (and (item= (fector-ref obj1 i)
			       (fector-ref obj2 i))
			(loop (+ 1 i)))))))))


;;;; done

#| end of module |# )

;;; end of file
