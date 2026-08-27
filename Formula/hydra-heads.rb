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
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.2.0/hydra-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "6fdbbc14fe6bf6ffd8e173d97d3aba1fdb31f51ebb8d63122e08a11123e8f5db"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.2.0/hydra-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "d83826ad7e8efbd38c51085f613f7209cdab969894a309a331cf659864e796c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.2.0/hydra-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5c8591c804ad258ddc9450d4c66e1e24f585d78394bcca701e14f0506d8e9406"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.2.0/hydra-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6951872c714433f542188ee973b12c5c5999f1d9c6db125b495e424cbfd38e4"
    end
  end

  conflicts_with "hydra", because: "both install a hydra executable"
  conflicts_with "ory-hydra", because: "both install a hydra executable"

  def install
    bin.install "hydra"
    pkgshare.install "hydra-art.txt"
    pkgshare.install "skills"
    pkgshare.install "LICENSE", "LICENSE-MIT", "LICENSE-APACHE"
  end

  def caveats
    art = (pkgshare/"hydra-art.txt").read
    "#{art}\nGet started:\n  hydra --help\n\nOptional Codex skill:\n  hydra skill install codex\n"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hydra --version")
    ENV["HOME"] = testpath
    system bin/"hydra", "skill", "install", "codex", "--yes"
    system bin/"hydra", "skill", "status", "codex"
    system bin/"hydra", "skill", "remove", "codex", "--yes"
  end
end
