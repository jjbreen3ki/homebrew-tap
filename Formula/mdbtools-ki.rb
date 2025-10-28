class MdbtoolsKi < Formula
  desc "MDB Tools - Read Access databases on *nix with -c and -C flags"
  homepage "https://github.com/jjbreen3ki/mdbtools-ki"
  url "https://github.com/jjbreen3ki/mdbtools-ki/archive/refs/tags/1.0.1-b.tar.gz"
  sha256 "87750c369d966137ecbc7a842eb6f7c4452dd70959e59e5583394ea57fbab024"
  license "GPL-2.0-or-later"

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
    system "./configure", "--enable-man", "--program-suffix=-ki", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mdb-schema-ki --drop-table test 2>&1", 1)

    expected_output = <<~EOS
      File not found
      Could not open file
    EOS
    assert_match expected_output, output
  end
end
