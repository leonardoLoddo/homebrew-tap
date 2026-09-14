# typed: strict
# frozen_string_literal: true

# Formula for the Hydra Git-native workspace manager.
class HydraHeads < Formula
  desc "Git-native workspace manager for isolated development Heads"
  homepage "https://github.com/leonardoLoddo/hydra"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.1.0/hydra-1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "fbd3f2af26c364d9067fab92d70c2a76283975d709cbff5b985f99f630bef542"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.1.0/hydra-1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "ba6f698b2a4b1b8019d24aa5096ebd64522d28fac0b61738e701dfa7f35e4e6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.1.0/hydra-1.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2145ccacfcc220e818f698bfc489143e5b4ef0228921c2cf4907543eefa2fe1"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.1.0/hydra-1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1e1443d7f815a8199c18562bc615ad8b33a214d5943a391e562f6e3c62362a08"
    end
  end

  conflicts_with "hydra", because: "both install a hydra executable"
  conflicts_with "ory-hydra", because: "both install a hydra executable"

  def install
    bin.install "hydra"
    generate_completions_from_executable(bin/"hydra", shell_parameter_format: :clap)
    pkgshare.install "hydra-art.txt"
    pkgshare.install "skills"
    pkgshare.install "LICENSE", "LICENSE-MIT", "LICENSE-APACHE"
  end

  def caveats
    art = (pkgshare/"hydra-art.txt").read
    <<~EOS
      #{art}
      Get started:
        hydra --help

      Optional AI-agent skill (choose a provider):
        hydra skill install codex
        hydra skill install gemini
        hydra skill install agy
        hydra skill install antigravity
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hydra --version")
    ENV["HOME"] = testpath
    system bin/"hydra", "skill", "install", "codex", "--yes"
    system bin/"hydra", "skill", "status", "codex"
    system bin/"hydra", "skill", "remove", "codex", "--yes"
  end
end
