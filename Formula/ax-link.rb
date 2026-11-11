class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.0/ax-link_1.5.0_darwin_arm64.tar.gz"
      sha256 "6be57fd1e6fa62ae038fc19627634ef33b9357407f5d828a1a199d985eb0f29b"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.0/ax-link_1.5.0_darwin_amd64.tar.gz"
      sha256 "426312ff83fbe42f78212b7e40e689c2e468ed3e8ecf1faaca5d729dedb4e125"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.0/ax-link_1.5.0_linux_arm64.tar.gz"
      sha256 "39a9913ef9756a1531951a8088a341f0fd1d22dcf096459cafc1a55d0a4e51db"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.5.0/ax-link_1.5.0_linux_amd64.tar.gz"
      sha256 "a32d09e0fcb3f28bb98b2114bf7dec94cccfe5ec6d92f104cbff935eae84fa7f"
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
