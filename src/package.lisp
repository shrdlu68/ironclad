;;;; -*- mode: lisp; indent-tabs-mode: nil -*-
(cl:defpackage :ironclad
  (:use :cl)
  (:nicknames :crypto)
  (:shadow null)
  (:import-from #:nibbles 
                #:ub16ref/le #:ub16ref/be
                #:ub32ref/le #:ub32ref/be
                #:ub64ref/le #:ub64ref/be)
  (:export
   ;; referencing multiple-octet values in an octet vector (SETF-able)
   #:ub16ref/be #:ub16ref/le #:ub32ref/be #:ub32ref/le #:ub64ref/le #:ub64ref/be

   ;; hash functions
   #:digest-sequence #:digest-stream #:digest-file
   #:make-digest #:copy-digest #:update-digest #:produce-digest

   ;; HMACs
   #:make-hmac #:update-hmac #:hmac-digest
   ;; CMACs
   #:make-cmac #:update-cmac #:cmac-digest
   ;; Skein-MAC
   #:make-skein-mac #:update-skein-mac #:skein-mac-digest

   ;; introspection
   #:cipher-supported-p #:list-all-ciphers
   #:digest-supported-p #:list-all-digests
   #:mode-supported-p #:list-all-modes
   #:block-length #:digest-length #:key-lengths

   ;; high-level block cipher operators
   #:make-cipher #:encrypt #:decrypt #:encrypt-in-place #:decrypt-in-place

   ;; arguments to (MAKE-CIPHER ... :MODE X)
   #:ecb #:cbc #:ctr #:ofb #:cfb #:stream

   ;; KDFs
   #:pbkdf1 #:pbkdf2 #:scrypt-kdf
   #:make-kdf #:derive-key

   ;; KDF convenience functions
   #:make-random-salt #:pbkdf2-hash-password
   #:pbkdf2-hash-password-to-combined-string
   #:pbkdf2-check-password

   ;; public-key encryption operations
   #:make-public-key #:make-private-key #:generate-key-pair
   #:sign-message #:verify-signature
   #:encrypt-message #:decrypt-message

   ;; public-key encryption/signature padding
   #:oaep-encode #:oaep-decode #:pss-encode #:pss-verify

   ;; public-key slot readers
   #:dsa-key-p #:dsa-key-q #:dsa-key-g #:dsa-key-y #:dsa-key-x
   #:elgamal-key-p #:elgamal-key-g #:elgamal-key-y #:elgamal-key-x
   #:rsa-key-modulus #:rsa-key-exponent
   #:ed25519-key-x #:ed25519-key-y

   ;; pseudo-random number generators
   #:pseudo-random-number-generator #:list-all-prngs #:make-prng #:random-data
   #:read-os-random-seed #:read-seed #:write-seed #:fortuna-prng
   #:add-random-event #:fortuna #:strong-random #:random-bits #:*prng*

   ;; ;; Diffie-Hellman key exchange
   #:dh-params
   #:generate-dh-params #:compute-dh-public-value #:compute-dh-secret

   ;; cryptographic math
   #:generate-prime #:prime-p #:generate-prime-in-range #:egcd
   #:generate-safe-prime #:find-generator

   ;; conditions
   #:ironclad-error #:initialization-vector-not-supplied
   #:invalid-initialization-vector #:invalid-key-length
   #:unsupported-cipher #:unsupported-mode #:unsupported-digest
   #:unsupported-kdf #:unsupported-scrypt-cost-factors
   #:insufficient-buffer-space #:invalid-padding
   #:key-not-supplied

   ;; utilities
   #:byte-array-to-hex-string #:hex-string-to-byte-array
   #:ascii-string-to-byte-array
   #:octets-to-integer #:integer-to-octets #:expt-mod #:expt-mod-fast

   ;; streams
   #:make-octet-input-stream #:make-octet-output-stream
   #:get-output-stream-octets

   #:make-digesting-stream

   #:execute-with-digesting-stream #:with-digesting-stream
   #:execute-with-digesting-text-stream #:with-digesting-text-stream)
  ;; supported digests
  (:export #:whirlpool #:md2 #:md4 #:md5 #:adler32 #:crc24 #:crc32
           #:tiger #:sha1 #:sha224 #:sha256 #:sha384 #:sha512
           #:tree-hash #:make-tiger-tree-hash #:ripemd-128 #:ripemd-160
           #:skein256 #:skein256/128 #:skein256/160 #:skein256/224
           #:skein512 #:skein512/128 #:skein512/160 #:skein512/224
           #:skein512/256 #:skein512/384
           #:skein1024 #:skein1024/384 #:skein1024/512)
  ;; supported block ciphers
  (:export #:blowfish #:tea #:xtea #:square #:rc2 #:rc5 #:rc6 #:des #:3des
           #:aes #:twofish #:cast5 #:idea #:misty1 #:null
           #:threefish256 #:threefish512 #:threefish1024)
  ;; supported stream ciphers
  (:export #:arcfour #:salsa20 #:salsa20/12 #:salsa20/8
           #:chacha #:chacha/12 #:chacha/8))
