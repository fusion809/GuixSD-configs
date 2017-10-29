;; This is an operating system configuration template
;; for a "desktop" setup with GNOME and Xfce where the
;; root partition is encrypted with LUKS.

(use-modules (gnu) (gnu system nss))
(use-service-modules desktop)
(use-package-modules certs gnome)

(operating-system
  (host-name "fusion809-vbox")
  (timezone "Australia/Brisbane")
  (locale "en_AU.utf8")

  ;; Assuming /dev/sdX is the target hard disk, and "my-root"
  ;; is the label of the target root file system.
  (bootloader (grub-configuration (target "/dev/sda")))

  (file-systems (cons (file-system
                        (device "my-root")
                        (title 'label)
                        (mount-point "/")
                        (type "ext4"))
                      %base-file-systems))

  (users (cons (user-account
                (name "fusion809")
                (comment "Admin")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/fusion809"))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (cons* nss-certs         ;for HTTPS access
                   gvfs              ;for user mounts
                   %base-packages))

  ;; Add GNOME and/or Xfce---we can choose at the log-in
  ;; screen with F1.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with Wicd,
  ;; and more.
  (services (cons* (gnome-desktop-service)
                   (console-keymap-service "us")
                   (modify-services %desktop-services 
                     (guix-service-type config =>
                       (guix-configuration
                         (inherit config)
                         (use-substitutes? #f)
                         (extra-options '("--cores=4" "--max-jobs=8")))))))
  (sudoers-file (local-file "/etc/guix/sudoers"))

  (name-service-switch %mdns-host-lookup-nss))
