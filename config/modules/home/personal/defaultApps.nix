{
  config,
  pkgs,
  lib,
  ...
}:
let
  browser = "firefox.desktop";
  imagePreviewer = "swappy";
  fileExplorer = "thunar.desktop";
in
{
  xdg.configFile."mimeapps.list".force = true; # Fix overwritten file
  xdg.mimeApps = {
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

      "image/aces" = imagePreviewer;
      "image/apng" = imagePreviewer;
      "image/avci" = imagePreviewer;
      "image/avcs" = imagePreviewer;
      "image/avif" = imagePreviewer;
      "image/bmp" = imagePreviewer;
      "image/cgm" = imagePreviewer;
      "image/dicom-rle" = imagePreviewer;
      "image/dpx" = imagePreviewer;
      "image/emf" = imagePreviewer;
      "image/example" = imagePreviewer;
      "image/fits" = imagePreviewer;
      "image/g3fax" = imagePreviewer;
      "image/gif" = imagePreviewer;
      "image/heic" = imagePreviewer;
      "image/heic-sequence" = imagePreviewer;
      "image/heif" = imagePreviewer;
      "image/heif-sequence" = imagePreviewer;
      "image/hej2k" = imagePreviewer;
      "image/hsj2" = imagePreviewer;
      "image/ief" = imagePreviewer;
      "image/j2c" = imagePreviewer;
      "image/jaii" = imagePreviewer;
      "image/jais" = imagePreviewer;
      "image/jls" = imagePreviewer;
      "image/jp2" = imagePreviewer;
      "image/jpeg" = imagePreviewer;
      "image/jph" = imagePreviewer;
      "image/jphc" = imagePreviewer;
      "image/jpm" = imagePreviewer;
      "image/jpx" = imagePreviewer;
      "image/jxl" = imagePreviewer;
      "image/jxr" = imagePreviewer;
      "image/jxrA" = imagePreviewer;
      "image/jxrS" = imagePreviewer;
      "image/jxs" = imagePreviewer;
      "image/jxsc" = imagePreviewer;
      "image/jxsi" = imagePreviewer;
      "image/jxss" = imagePreviewer;
      "image/ktx" = imagePreviewer;
      "image/ktx2" = imagePreviewer;
      "image/naplps" = imagePreviewer;
      "image/png" = imagePreviewer;
      "image/prs.btif" = imagePreviewer;
      "image/prs.pti" = imagePreviewer;
      "image/pwg-raster" = imagePreviewer;
      "image/svg+xml" = imagePreviewer;
      "image/t38" = imagePreviewer;
      "image/tiff" = imagePreviewer;
      "image/tiff-fx" = imagePreviewer;
      "image/vnd.adobe.photoshop" = imagePreviewer;
      "image/vnd.airzip.accelerator.azv" = imagePreviewer;
      "image/vnd.blockfact.facti" = imagePreviewer;
      "image/vnd.clip" = imagePreviewer;
      "image/vnd.cns.inf2" = imagePreviewer;
      "image/vnd.dece.graphic" = imagePreviewer;
      "image/vnd.djvu" = imagePreviewer;
      "image/vnd.dwg" = imagePreviewer;
      "image/vnd.dxf" = imagePreviewer;
      "image/vnd.dvb.subtitle" = imagePreviewer;
      "image/vnd.fastbidsheet" = imagePreviewer;
      "image/vnd.fpx" = imagePreviewer;
      "image/vnd.fst" = imagePreviewer;
      "image/vnd.fujixerox.edmics-mmr" = imagePreviewer;
      "image/vnd.fujixerox.edmics-rlc" = imagePreviewer;
      "image/vnd.globalgraphics.pgb" = imagePreviewer;
      "image/vnd.microsoft.icon" = imagePreviewer;
      "image/vnd.mix" = imagePreviewer;
      "image/vnd.ms-modi" = imagePreviewer;
      "image/vnd.mozilla.apng" = imagePreviewer;
      "image/vnd.net-fpx" = imagePreviewer;
      "image/vnd.pco.b16" = imagePreviewer;
      "image/vnd.radiance" = imagePreviewer;
      "image/vnd.sealed.png" = imagePreviewer;
      "image/vnd.sealedmedia.softseal.gif" = imagePreviewer;
      "image/vnd.sealedmedia.softseal.jpg" = imagePreviewer;
      "image/vnd.svf" = imagePreviewer;
      "image/vnd.tencent.tap" = imagePreviewer;
      "image/vnd.valve.source.texture" = imagePreviewer;
      "image/vnd.wap.wbmp" = imagePreviewer;
      "image/vnd.xiff" = imagePreviewer;
      "image/vnd.zbrush.pcx" = imagePreviewer;
      "image/webp" = imagePreviewer;
    };
  };
}
