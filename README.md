# vpn-nsswitch

A lightweight Debian package for Ubuntu that automates `/etc/nsswitch.conf` modifications to fix SSH DNS resolution issues for `.local` hostnames when using OpenVPN or WireGuard VPNs managed by NetworkManager.

When a VPN is activated, it sets:

```
hosts: files dns mdns4
```

to prioritize DNS resolution, ensuring SSH can resolve `.local` hostnames (e.g., `host.local`). When the VPN is deactivated, it restores:

```
hosts: files mdns4_minimal [NOTFOUND=return] dns
```

to maintain default mDNS behavior.

---

## Features

- Supports OpenVPN and WireGuard VPNs with NetworkManager
- Automatically modifies `/etc/nsswitch.conf` when VPN connects/disconnects
- Preserves system integrity with backups and logging (`/var/log/nsswitch_script.log`)
- Easy installation via `.deb` package or local build scripts
- Compatible with Ubuntu 24.04 (other versions may work but are untested)

---

## Installation

### Helper Install Script

```sh
curl -sSL https://raw.githubusercontent.com/mdelgert/vpn-nsswitch/main/tools/install.sh | bash
```

### Helper Uninstall Script

```sh
curl -sSL https://raw.githubusercontent.com/mdelgert/vpn-nsswitch/main/tools/uninstall.sh | bash
```

### Manual Install (Prebuilt Package)

Download the latest `.deb` package from the [Releases page](https://github.com/mdelgert/vpn-nsswitch/releases).

Install using `dpkg`:

```sh
wget -O vpn-nsswitch.deb $(curl -s https://api.github.com/repos/mdelgert/vpn-nsswitch/releases/latest | grep "browser_download_url.*deb" | cut -d '"' -f 4)
sudo dpkg -i vpn-nsswitch.deb
sudo apt-get install -f
```

### Local Build and Install (For Developers)

You can build and install the package locally using the provided scripts:

```sh
cd tools
./build.sh         # Build the .deb package
./install-local.sh # Install the built package locally
```

To remove:

```sh
./remove.sh
```

---

## Verify Installation

Check installed package:

```sh
dpkg -l vpn-nsswitch
```

Confirm scripts and configs:

```sh
ls /etc/nsswitch.d/
ls /etc/NetworkManager/dispatcher.d/vpn-nsswitch-*.sh
```

---

## Usage

### Ensure VPN Configuration

- Your VPN must be named `WireGuard` (for WireGuard) or `OpenVPN` (for OpenVPN) in NetworkManager.
- Interface must be `wg0` (WireGuard) or `tun0` (OpenVPN).

Verify:

```sh
nmcli connection show
```

---

### Activate VPN

```sh
nmcli connection up WireGuard  # Or OpenVPN
```

Or use the Network Settings GUI.

Check `nsswitch.conf`:

```sh
cat /etc/nsswitch.conf
```

Should show:

```
hosts: files dns mdns4
```

---

### Test SSH

```sh
ssh host.local
```

---

### Deactivate VPN

```sh
nmcli connection down WireGuard  # Or OpenVPN
```

Check:

```sh
cat /etc/nsswitch.conf
```

Should show:

```
hosts: files mdns4_minimal [NOTFOUND=return] dns
```

---

### View Logs

```sh
cat /var/log/nsswitch_script.log
```

---

## Requirements

- **OS:** Ubuntu 24.04 (other versions may work but are untested)
- **Dependencies:** `network-manager`, `wireguard` (for WireGuard), `openvpn` (for OpenVPN), `bash`
- **VPN:** NetworkManager-managed VPN named `WireGuard` or `OpenVPN` with interface `wg0` or `tun0`
- **Permissions:** Root access for installation and script execution

---

## Troubleshooting

### SSH Still Fails

- Verify `/etc/nsswitch.conf` after VPN activation.
- Check logs:

  ```sh
  cat /var/log/nsswitch_script.log
  ```
- Ensure `~/.ssh/config` doesn’t override `host.local`:

  ```sh
  cat ~/.ssh/config
  ```

**Fix:**

```sshconfig
Host host.local
    HostName 192.168.50.241
    User <username>
```

---

### mDNS Devices (e.g., printers) Fail

The `hosts: files dns mdns4` setting may delay mDNS resolution.

Test:

```sh
ping printer.local
avahi-browse -a
```

**Alternative:** Edit `/etc/nsswitch.d/nsswitch_up.conf`:

```
hosts: files mdns4_minimal dns
```

Re-run:

```sh
sudo /etc/nsswitch.d/nsswitch_up.sh
```

---

### Dispatcher Not Triggering

Check NetworkManager dispatcher:

```sh
systemctl status NetworkManager-dispatcher.service
```

Restart:

```sh
sudo systemctl restart NetworkManager-dispatcher.service
```

Verify VPN name and interface:

```sh
nmcli connection show WireGuard
```

---

## Uninstallation

Remove the package:

```sh
sudo apt remove vpn-nsswitch
```

This runs `/etc/nsswitch.d/nsswitch_down.sh` to restore `/etc/nsswitch.conf`.

---

## Contributing

Contributions are welcome! Please:

1. Fork the repository.
2. Create a feature branch:
   ```sh
   git checkout -b feature-name
   ```
3. Commit changes:
   ```sh
   git commit -m "Add feature"
   ```
4. Push:
   ```sh
   git push origin feature-name
   ```
5. Open a Pull Request.

Report issues or suggest features on the [Issues page](https://github.com/mdelgert/vpn-nsswitch/issues).

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Inspired by the need to fix SSH DNS resolution for `.local` hostnames over VPNs.
- Built with [jtdor/build-deb-action](https://github.com/jtdor/build-deb-action) for Debian packaging.

---

## Contact

For questions, contact **Your Name** or open an issue on [GitHub](https://github.com/mdelgert/vpn-nsswitch/issues).
