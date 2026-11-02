"""Contact sheet: python -I sheet.py <dir> <out.jpg> [cols] [width]"""
import os, sys
from PIL import Image, ImageDraw
d, out = sys.argv[1], sys.argv[2]
cols = int(sys.argv[3]) if len(sys.argv) > 3 else 5
w = int(sys.argv[4]) if len(sys.argv) > 4 else 300
files = sorted(f for f in os.listdir(d) if f.endswith('.jpg'))
if not files:
    sys.exit('no shots')
ims = []
for f in files:
    im = Image.open(os.path.join(d, f)).convert('RGB')
    h = int(im.height * w / im.width)
    ims.append((f, im.resize((w, h))))
h = ims[0][1].height
rows = (len(ims) + cols - 1) // cols
sheet = Image.new('RGB', (cols * w, rows * (h + 16)), (24, 24, 28))
dr = ImageDraw.Draw(sheet)
for i, (f, im) in enumerate(ims):
    x, y = (i % cols) * w, (i // cols) * (h + 16)
    sheet.paste(im, (x, y + 16))
    dr.text((x + 3, y + 2), f[:-4][:46], fill=(230, 230, 230))
sheet.save(out, quality=80)
print(out, len(ims))
