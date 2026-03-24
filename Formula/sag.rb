class Sag < Formula
  desc "Neural text-to-speech CLI using KittenTTS — like macOS say, but with neural voices"
  homepage "https://github.com/tscherrie/sag"
  url "https://github.com/tscherrie/sag/archive/refs/tags/v2.3.0.tar.gz"
  sha256 "e67d40438a1da90e1b20561e860901f7e40513e43287305b992232b928c7611c"
  license "MIT"

  depends_on "python@3.12"
  depends_on "ffmpeg"

  def install
    python3 = "python3.12"
    venv = libexec/"venv"

    system python3, "-m", "venv", venv
    venv_pip = venv/"bin/pip"

    # Install kittentts from GitHub wheel and our package
    system venv_pip, "install", "--no-cache-dir",
      "https://github.com/KittenML/KittenTTS/releases/download/0.8.1/kittentts-0.8.1-py3-none-any.whl"
    system venv_pip, "install", "--no-cache-dir", buildpath

    # Link the sag binary
    (bin/"sag").write_env_script venv/"bin/sag", PATH: "#{Formula["ffmpeg"].opt_bin}:#{ENV["PATH"]}"
  end

  test do
    assert_match "2.3.0", shell_output("#{bin}/sag --version")
  end
end
