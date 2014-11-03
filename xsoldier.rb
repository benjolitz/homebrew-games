require "formula"

class Xsoldier < Formula
  homepage "http://www.interq.or.jp/libra/oohara/xsoldier/"
  url "http://www.interq.or.jp/libra/oohara/xsoldier/xsoldier-1.8.tar.gz"
  sha1 "51ef7a55d0062015c54b5e31263875ba16068e10"

  depends_on :x11
  depends_on "sdl"
  depends_on "sdl_image"

  def install
    sdl = Formula["sdl"].opt_prefix
    sdl_image = Formula["sdl_image"].opt_prefix
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "CFLAGS=-DHAVE_MALLOC_H=1 -DHAVE_LIBSDL=1 \
                    -I/usr/include/sys -I#{sdl}/include/SDL \
                    -I#{sdl_image}/include/SDL", "LDFLAGS=-L#{sdl}/lib \
                    -L#{sdl_image}/lib #{sdl}/lib/libSDLmain.a  -lSDL \
                    -framework Cocoa -lSDL_image"
    system "make", "install"
  end

  test do
    system "false"
  end
end
