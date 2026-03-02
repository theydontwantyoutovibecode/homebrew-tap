# typed: false
# frozen_string_literal: true

class Justvibin < Formula
  desc "CLI for scaffolding, developing, and serving projects with zero-friction HTTPS"
  homepage "https://github.com/theydontwantyoutovibecode/justvibin"
  url "https://github.com/theydontwantyoutovibecode/justvibin.git",
    tag: "v1.0.2"
  license "MIT"

  depends_on "go" => :build
  depends_on "caddy"
  depends_on "git"
  depends_on "jq"
  depends_on "wedow/tap/ticket"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/theydontwantyoutovibecode/justvibin/internal/version.Version=#{version}"), "./cmd/justvibin"
  end

  def caveats
    <<~EOS
      Optional dependencies for additional features:
        brew install cloudflared  # public tunnels via justvibin share
    EOS
  end

  test do
    assert_match "justvibin v#{version}", shell_output("#{bin}/justvibin version")
  end
end
