class Mdbtoolsk3 < Formula
  desc "MDB Tools - Read Access databases on *nix k3"
  homepage "https://github.com/jjbreen3ki/mdbtools-ki"
  url "https://github.com/jjbreen3ki/mdbtools-ki/archive/refs/tags/1.0.1-b.tar.gz"
  sha256 "87750c369d966137ecbc7a842eb6f7c4452dd70959e59e5583394ea57fbab024"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/jjbreen3ki/homebrew-tap/releases/download/mdbtoolsk3-1.0.1"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:  "4d623086f11226cf5b267b4069ed1ad8514ee80f32303f78dbbc7f7bfa269de4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cc274244ae10d7fe4e1f33ed3e717b9183520fe9bc885f7b4d7040ad8754064d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "gawk" => :build
  depends_on "gettext" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  depends_on "glib"
  depends_on "readline"

  on_macos do
    depends_on "gettext"
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose", "-I", "#{ENV["HOMEBREW_PREFIX"]}/share/gettext/m4"
    system "./configure", "--enable-man", "--program-suffix=-k3", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mdb-schema-k3 --drop-table test 2>&1", 1)

    expected_output = <<~EOS
      File not found
      Could not open file
    EOS
    assert_match expected_output, output
  end
end
