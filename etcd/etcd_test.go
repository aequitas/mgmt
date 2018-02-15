package etcd

import (
	"testing"

	etcdtypes "github.com/coreos/etcd/pkg/types"
)

func TestNewEmbdEtcd(t *testing.T) {
	// should return a new etcd object

	noServer := false
	var flags Flags

	obj := NewEmbdEtcd("", nil, nil, nil, nil, nil, noServer, 0, flags, "", nil)
	if obj == nil {
		t.Fatal("failed to create server object")
	}
}

func TestNewEmbdEtcdConfigValidation(t *testing.T) {
	// running --no-server with no --seeds specified should fail early

	seeds := make(etcdtypes.URLs, 0)
	noServer := true
	var flags Flags

	obj := NewEmbdEtcd("", seeds, nil, nil, nil, nil, noServer, 0, flags, "", nil)
	if obj != nil {
		t.Fatal("server initialization should fail on invalid configuration")
	}
}
