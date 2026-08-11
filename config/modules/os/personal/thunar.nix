{
  pkgs,
  ...
}:

{
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
  };

  services = {
    tumbler.enable = true; # Image thumbnails
    gvfs.enable = true; # Lets Thunar mount things
    # Defaults from here https://storaged.org/doc/udisks2-api/latest/mount_options.html plus x-gvfs-notrash
    udisks2.settings."mount_options.conf" = {
      defaults = {
        "allow" =
          "exec,noexec,nodev,nosuid,atime,noatime,nodiratime,relatime,strictatime,lazytime,ro,rw,sync,dirsync,noload,acl,nosymfollow,x-gvfs-notrash";

        "vfat_defaults" = "uid=$UID,gid=$GID,shortname=mixed,utf8=1,showexec,flush,x-gvfs-notrash";
        "vfat_allow" =
          "uid=$UID,gid=$GID,flush,utf8,shortname,umask,dmask,fmask,codepage,iocharset,usefree,showexec,x-gvfs-notrash";

        # common options for both the native kernel driver and exfat-fuse
        "exfat_defaults" = "uid=$UID,gid=$GID,iocharset=utf8,errors=remount-ro,x-gvfs-notrash";
        "exfat_allow" = "uid=$UID,gid=$GID,dmask,errors,fmask,iocharset,namecase,umask,x-gvfs-notrash";

        # 'ntfs' signature, definitions for the legacy ntfs kernel driver and the ntfs-3g fuse driver
        "ntfs:ntfs_defaults" = "uid=$UID,gid=$GID,windows_names,x-gvfs-notrash";
        "ntfs:ntfs_allow" =
          "uid=$UID,gid=$GID,umask,dmask,fmask,locale,norecover,ignore_case,windows_names,compression,nocompression,big_writes,x-gvfs-notrash";

        # 'ntfs' signature, the new 'ntfs3' kernel driver
        "ntfs:ntfs3_defaults" = "uid=$UID,gid=$GID,x-gvfs-notrash";
        "ntfs:ntfs3_allow" =
          "uid=$UID,gid=$GID,umask,dmask,fmask,iocharset,discard,nodiscard,sparse,nosparse,hidden,nohidden,sys_immutable,nosys_immutable,showmeta,noshowmeta,prealloc,noprealloc,hide_dot_files,nohide_dot_files,windows_names,nocase,case,x-gvfs-notrash";

        # define order of filesystem driver priorities for the actual mount call,
        # required definition for non-matching driver names
        "ntfs_drivers" = "ntfs3,ntfs,x-gvfs-notrash";

        "iso9660_defaults" = "uid=$UID,gid=$GID,iocharset=utf8,mode=0400,dmode=0500,x-gvfs-notrash";
        "iso9660_allow" = "uid=$UID,gid=$GID,norock,nojoliet,iocharset,mode,dmode,map,check,x-gvfs-notrash";

        "udf_defaults" = "uid=$UID,gid=$GID,iocharset=utf8,x-gvfs-notrash";
        "udf_allow" = "uid=$UID,gid=$GID,iocharset,utf8,umask,mode,dmode,unhide,undelete,x-gvfs-notrash";

        "hfsplus_defaults" = "uid=$UID,gid=$GID,nls=utf8,x-gvfs-notrash";
        "hfsplus_allow" =
          "uid=$UID,gid=$GID,creator,type,umask,session,part,decompose,nodecompose,force,nls,x-gvfs-notrash";

        "btrfs_allow" =
          "compress,compress-force,datacow,nodatacow,datasum,nodatasum,autodefrag,noautodefrag,degraded,device,discard,nodiscard,subvol,subvolid,space_cache,x-gvfs-notrash";

        "f2fs_allow" =
          "discard,nodiscard,compress_algorithm,compress_log_size,compress_extension,compress_chksum,alloc_mode,atgc,gc_merge,nogc_merge,x-gvfs-notrash";

        "xfs_allow" = "discard,nodiscard,inode32,largeio,wsync,x-gvfs-notrash";

        "reiserfs_allow" = "hashed_relocation,no_unhashed_relocation,noborder,notail,x-gvfs-notrash";

        "ext2_defaults" = "errors=remount-ro,x-gvfs-notrash";
        "ext2_allow" = "errors=remount-ro,x-gvfs-notrash";

        "ext3_defaults" = "errors=remount-ro,x-gvfs-notrash";
        "ext3_allow" = "errors=remount-ro,commit,x-gvfs-notrash";

        "ext4_defaults" = "errors=remount-ro,x-gvfs-notrash";
        "ext4_allow" = "errors=remount-ro,commit,x-gvfs-notrash";
      };
    };
  };
}
