//go:build !noasm && !appengine
// +build !noasm,!appengine

package simdsort

import (
	"unsafe"
)

//go:noescape
func _AVX512Sort(keys, values unsafe.Pointer, value_size, vaules_size int64, result unsafe.Pointer)

func AVX512Sort(keys []uint64, values [][]byte, value_size, vaules_size int64) bool {

	ret := false

	_AVX512Sort(unsafe.Pointer(&keys), unsafe.Pointer(&values), value_size, vaules_size, unsafe.Pointer(&ret))

	return ret
}
