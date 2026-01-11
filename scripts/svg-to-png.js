import sharp from 'sharp';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { existsSync, mkdirSync } from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const svgPath = join(__dirname, '../public/favicon.svg');
const outDir = join(__dirname, '../public');

async function convert() {
  try {
    if (!existsSync(outDir)) mkdirSync(outDir, { recursive: true });

    await sharp(svgPath)
      .resize(192, 192, { fit: 'inside', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png()
      .toFile(join(outDir, 'pwa-192x192.png'));

    await sharp(svgPath)
      .resize(512, 512, { fit: 'inside', background: { r: 0, g: 0, b: 0, alpha: 0 } })
      .png()
      .toFile(join(outDir, 'pwa-512x512.png'));

    console.log('✅  已生成 pwa-192x192.png 和 pwa-512x512.png');
  } catch (err) {
    console.error('❌  转换失败：', err);
    process.exit(1);
  }
}

convert();