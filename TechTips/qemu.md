# QEMU Virtualization Tips

## Basic Commands
```bash
# Run a virtual machine
qemu-system-x86_64 -hda disk.img -m 2048

# Create disk image
qemu-img create -f qcow2 disk.qcow2 10G
```

## Common Options
- `-m`: Specify memory size
- `-enable-kvm`: Enable KVM acceleration
- `-net`: Configure networking

## Useful Features
- Snapshot management
- Device passthrough
- ARM emulation