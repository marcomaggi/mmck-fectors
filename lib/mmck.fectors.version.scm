;;; -*- coding: utf-8-unix  -*-
;;;
;;;Part of: MMCK Fectors
;;;Contents: version functions
;;;Date: Apr 24, 2019
;;;
;;;Abstract
;;;
;;;	This unit defines version functions.
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
;;;


;;;; units and module header

(declare (unit mmck.fectors.version)
	 (emit-import-library mmck.fectors.version))

(module (mmck.fectors.version)
    (mmck-fectors-package-major-version
     mmck-fectors-package-minor-version
     mmck-fectors-package-patch-level
     mmck-fectors-package-prerelease-tag
     mmck-fectors-package-build-metadata
     mmck-fectors-package-version
     mmck-fectors-package-semantic-version)
  (import (scheme)
	  (prefix mmck.fectors.config config::))


;;;; version functions

(define (mmck-fectors-package-major-version)		config::MMUX_PKG_MAJOR_VERSION)
(define (mmck-fectors-package-minor-version)		config::MMUX_PKG_MINOR_VERSION)
(define (mmck-fectors-package-patch-level)		config::MMUX_PKG_PATCH_LEVEL)
(define (mmck-fectors-package-prerelease-tag)		config::MMUX_PKG_PRERELEASE_TAG)
(define (mmck-fectors-package-build-metadata)		config::MMUX_PKG_BUILD_METADATA)
(define (mmck-fectors-package-version)			config::MMUX_PKG_VERSION)
(define (mmck-fectors-package-semantic-version)		config::MMUX_PKG_SEMANTIC_VERSION)


;;;; done

#| end of module |# )

;;; end of file
