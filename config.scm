;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS.

(use-modules 
  (gnu)
  (gnu system nss)
  (gnu packages base)
  (gnu packages shells)
  )
(use-service-modules desktop)
(use-package-modules certs gnome)
(use-package-modules shells)

(operating-system
  (host-name "fusion809-vbox")
  (timezone "Australia/Brisbane")
  (locale "en_AU.utf8")
;;  (shell "/run/current-system/profile/bin/zsh")

  ;; Assuming /dev/sdX is the target hard disk, and "my-root"
  ;; is the label of the target root file system.
  (bootloader (bootloader-configuration
                (bootloader grub-bootloader)
                (target "/dev/sda")))

  ;; Specify a mapped device for the encrypted root partition.
  ;; The UUID is that returned by 'cryptsetup luksUUID'.
  (file-systems (cons (file-system
                        (device "guixsd")
                        (mount-point "/")
                        (type "btrfs"))
                      %base-file-systems))

  (users (cons (user-account
                (name "fusion809")
                (comment "Brenton Horne")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/fusion809")
		(shell "/run/current-system/profile/bin/zsh"))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (cons* nss-certs         ;for HTTPS access
		   zsh               ; for Z shell
                   gvfs              ;for user mounts
                   %base-packages))

  ;; Add GNOME and/or Xfce---we can choose at the log-in
  ;; screen with F1.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with Wicd,
  ;; and more.
  (services (cons* (gnome-desktop-service)
                   %desktop-services))

  (sudoers-file (local-file "/etc/guix/sudoers"))
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
