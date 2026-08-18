class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.1/ax-link_1.2.1_darwin_arm64.tar.gz"
      sha256 "86eb55528415664559e9defbe280c599d8705b979f1d415ea83f221667c46ca0"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.1/ax-link_1.2.1_darwin_amd64.tar.gz"
      sha256 "1c187e7e55cd0ae774db5fed03eb97f5ddbe8b0d0e7aec1a03a5797ab7e58d4d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.1/ax-link_1.2.1_linux_arm64.tar.gz"
      sha256 "dead9362486ef5bb28c5d9ea35a4d87c5383508a7549e78aa2e1f6f447e13e0a"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.1/ax-link_1.2.1_linux_amd64.tar.gz"
      sha256 "2a3c97289db999222b24c8dd5e56d0992b73be095a58b8fbb0ae0dba8dfb43cf"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
  end
end
