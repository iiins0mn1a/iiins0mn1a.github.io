# SSH Connection Tips

## Basic Usage
```bash
ssh username@hostname
ssh -p port username@hostname
```

## Key Authentication
```bash
# Generate key pair
ssh-keygen -t rsa

# Copy public key to server
ssh-copy-id username@hostname
```

## Configuration Tips
- `~/.ssh/config` for host aliases
- Port forwarding with `-L` and `-R`
- SOCKS proxy with `-D`