class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.4.0/ax-link_1.4.0_darwin_arm64.tar.gz"
      sha256 "2de15b97b7d9a161eb9f4a45b651e76b2a89ee25d05a6c238ff2af8f0b485bad"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.4.0/ax-link_1.4.0_darwin_amd64.tar.gz"
      sha256 "add71e5df33f356ed2d9c36ca8fe154f07684407e6e51a4036baf1f730da996d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.4.0/ax-link_1.4.0_linux_arm64.tar.gz"
      sha256 "df68b100eb29794f82eac38cd30afc6b5f4ca92d47ffbb9d20154f11518e27bf"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.4.0/ax-link_1.4.0_linux_amd64.tar.gz"
      sha256 "39de8e9f43ed66bab7a6267d5212ad934c47f882509ce860bc04cfbbfb5d8d17"
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
