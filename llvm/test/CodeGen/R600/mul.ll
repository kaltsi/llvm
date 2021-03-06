;RUN: llc < %s -march=r600 -mcpu=redwood | FileCheck %s

; mul24 and mad24 are affected
;CHECK: MULLO_INT * T{{[0-9]+\.[XYZW], T[0-9]+\.[XYZW], T[0-9]+\.[XYZW]}}
;CHECK: MULLO_INT * T{{[0-9]+\.[XYZW], T[0-9]+\.[XYZW], T[0-9]+\.[XYZW]}}
;CHECK: MULLO_INT * T{{[0-9]+\.[XYZW], T[0-9]+\.[XYZW], T[0-9]+\.[XYZW]}}
;CHECK: MULLO_INT * T{{[0-9]+\.[XYZW], T[0-9]+\.[XYZW], T[0-9]+\.[XYZW]}}

define void @test(<4 x i32> addrspace(1)* %out, <4 x i32> addrspace(1)* %in) {
  %b_ptr = getelementptr <4 x i32> addrspace(1)* %in, i32 1
  %a = load <4 x i32> addrspace(1) * %in
  %b = load <4 x i32> addrspace(1) * %b_ptr
  %result = mul <4 x i32> %a, %b
  store <4 x i32> %result, <4 x i32> addrspace(1)* %out
  ret void
}
