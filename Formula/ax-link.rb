class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.1/ax-link_1.5.1_darwin_arm64.tar.gz"
      sha256 "c59f5336b45b7d101a00e9e354d26ff598f4ec96758c199720ed847a35993abe"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.1/ax-link_1.5.1_darwin_amd64.tar.gz"
      sha256 "0d76a9717e8067cebb0ac2ebde745874fe4caecc0db78ba2acaddf917770c3c7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.1/ax-link_1.5.1_linux_arm64.tar.gz"
      sha256 "8a810e279af01c505413b4dc593921dea91f4c61bed855e543d88fcaedf9637a"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.1/ax-link_1.5.1_linux_amd64.tar.gz"
      sha256 "627edb04873427cd6b3be17279c4813c4f11f76d3db9398931e297efec466186"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
    assert_match "ax-link setup orca", shell_output("#{bin}/ax-link help")
  end
end
