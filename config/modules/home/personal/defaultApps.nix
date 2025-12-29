{
  config,
  pkgs,
  lib,
  ...
}:
let
  assign =
    application: mimeTypes:
    builtins.listToAttrs (
      map (mimeType: {
        name = mimeType;
        value = application;
      }) mimeTypes
    );

  browser = "firefox.desktop";
  imagePreviewer = "swappy.desktop";
  fileExplorer = "thunar.desktop";

  images = [
    "image/aces"
    "image/apng"
    "image/avci"
    "image/avcs"
    "image/avif"
    "image/bmp"
    "image/cgm"
    "image/dicom-rle"
    "image/dpx"
    "image/emf"
    "image/example"
    "image/fits"
    "image/g3fax"
    "image/gif"
    "image/heic"
    "image/heic-sequence"
    "image/heif"
    "image/heif-sequence"
    "image/hej2k"
    "image/hsj2"
    "image/ief"
    "image/j2c"
    "image/jaii"
    "image/jais"
    "image/jls"
    "image/jp2"
    "image/jpeg"
    "image/jph"
    "image/jphc"
    "image/jpm"
    "image/jpx"
    "image/jxl"
    "image/jxr"
    "image/jxrA"
    "image/jxrS"
    "image/jxs"
    "image/jxsc"
    "image/jxsi"
    "image/jxss"
    "image/ktx"
    "image/ktx2"
    "image/naplps"
    "image/png"
    "image/prs.btif"
    "image/prs.pti"
    "image/pwg-raster"
    "image/svg+xml"
    "image/t38"
    "image/tiff"
    "image/tiff-fx"
    "image/vnd.adobe.photoshop"
    "image/vnd.airzip.accelerator.azv"
    "image/vnd.blockfact.facti"
    "image/vnd.clip"
    "image/vnd.cns.inf2"
    "image/vnd.dece.graphic"
    "image/vnd.djvu"
    "image/vnd.dwg"
    "image/vnd.dxf"
    "image/vnd.dvb.subtitle"
    "image/vnd.fastbidsheet"
    "image/vnd.fpx"
    "image/vnd.fst"
    "image/vnd.fujixerox.edmics-mmr"
    "image/vnd.fujixerox.edmics-rlc"
    "image/vnd.globalgraphics.pgb"
    "image/vnd.microsoft.icon"
    "image/vnd.mix"
    "image/vnd.ms-modi"
    "image/vnd.mozilla.apng"
    "image/vnd.net-fpx"
    "image/vnd.pco.b16"
    "image/vnd.radiance"
    "image/vnd.sealed.png"
    "image/vnd.sealedmedia.softseal.gif"
    "image/vnd.sealedmedia.softseal.jpg"
    "image/vnd.svf"
    "image/vnd.tencent.tap"
    "image/vnd.valve.source.texture"
    "image/vnd.wap.wbmp"
    "image/vnd.xiff"
    "image/vnd.zbrush.pcx"
    "image/webp"
  ];
in
{
  xdg = {
    configFile."mimeapps.list".force = true; # Fix overwritten file

    desktopEntries = {
      swappy = {
        name = "Swappy";
        genericName = "Image Previewer";
        exec = "swappy -f %U";
        terminal = false;
        mimeType = images;
      };
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        # Full list https://www.iana.org/assignments/media-types/media-types.xhtml

        "inode/directory" = fileExplorer;

        "text/plain" = "codium.desktop";

        "default-web-browser" = browser;
        "application/xhtml+xml" = browser;
        "application/pdf" = browser;
        "text/xml" = browser;
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;
      }
      // assign imagePreviewer images;
    };
  };
}
