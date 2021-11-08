for f in outputs/*; do
  BASE=$(basename $f .svg)
  rsvg-convert -f pdf -o outputs/$BASE.pdf outputs/$BASE.svg
done
