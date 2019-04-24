;;; -*- coding: utf-8-unix  -*-
;;;
;;;Part of: MMCK Fectors
;;;Contents: test program for fectors
;;;Date: Apr  2, 2019
;;;
;;;Abstract
;;;
;;;	This program is a test of fectors' features.
;;;
;;;Copyright (C) 2012, 2019 Marco Maggi <marco.maggi-ipsu@poste.it>
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
;;;


;;;; units and module header

(require-library (mmck fectors))
(require-library (mmck checks))

(module (test-fectors)
    ()
  (import (scheme)
	  (only (chicken base)
		case-lambda)
	  (mmck fectors)
	  (mmck checks))

(check-set-mode! 'report-failed)
(check-display "*** testing fectors\n")


;;;; helpers

(define fector=?
  (case-lambda
   ((obj1 obj2)
    (fector=? obj1 obj2 eqv?))
   ((obj1 obj2 item=)
    (and (fector? obj1)
	 (fector? obj2)
	 (or (eq? obj1 obj2)
	     (let ((len1 (fector-length obj1)))
	       (and (= len1 (fector-length obj2))
		    (let loop ((i 0))
		      (or (= i len1)
			  (and (item= (fector-ref obj1 i)
				      (fector-ref obj2 i))
			       (loop (+ 1 i))))))))))))


;;;; building fectors

(check
    (let ((F (make-fector 5 #\a)))
      (and (fector? F)
	   (fector->list F)))
  => '(#\a #\a #\a #\a #\a))

(check
    (let ((F (fector 1 2 3)))
      (and (fector? F)
	   (fector->list F)))
  => '(1 2 3))

(check
    (let ((F (build-fector 5 (lambda (idx) (* 10 idx)))))
      (and (fector? F)
	   (fector->list F)))
  => '(0 10 20 30 40))

;;; --------------------------------------------------------------------
;;; test predicate

(check
    (fector? 123)
  => #f)

(check
    (fector? '#(1 2 3))
  => #f)


;;;; inspecting

(check
    (let ((F (fector)))
      (fector-length F))
  => 0)

(check
    (let ((F (fector 1)))
      (fector-length F))
  => 1)

(check
    (let ((F (fector 1 2 3)))
      (fector-length F))
  => 3)


;;;; accessing and mutating

(check
    (let ((F (fector 1 2 3)))
      (list (fector-ref F 0)
	    (fector-ref F 1)
	    (fector-ref F 2)))
  => '(1 2 3))

(check
    (let* ((F (fector 1 2 3))
	   (F (fector-set F 0 'a))
	   (F (fector-set F 1 'b))
	   (F (fector-set F 2 'c)))
      (list (fector-ref F 0)
	    (fector-ref F 1)
	    (fector-ref F 2)))
  => '(a b c))


;;;; comparison

(check
    (let ((F (fector 1 2 3))
	  (G (fector 1 2 3)))
      (fector=? F G))
  => #t)

(check
    (let ((F (fector 1 2 3))
	  (G (fector 10 2 3)))
      (fector=? F G))
  => #f)

(check
    (let ((F (fector 1 2 3))
	  (G (fector 1 20 3)))
      (fector=? F G))
  => #f)

(check
    (let ((F (fector 1 2 3))
	  (G (fector 1 2 30)))
      (fector=? F G))
  => #f)

;;; --------------------------------------------------------------------

(check
    (let ((F (fector 1 2 3))
	  (G (fector 1 2 3 4)))
      (fector=? F G))
  => #f)

(check
    (let ((F (fector 1 2 3 4))
	  (G (fector 1 2 3)))
      (fector=? F G))
  => #f)

(check
    (let ((F (fector))
	  (G (fector 1 2 3)))
      (fector=? F G))
  => #f)

(check
    (let ((F (fector 1 2 3))
	  (G (fector)))
      (fector=? F G))
  => #f)


;;;; conversion

(check
    (let ((F (fector 1 2 3)))
      (fector->list F))
  => '(1 2 3))

(check
    (list->fector '(1 2 3))
  (=> fector=?) (fector 1 2 3))


;;;; done

(check-report)

#| end of module |# )

;;; end of file
