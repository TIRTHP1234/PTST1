const fs = require('fs');
const { getDocument } = require('pdfjs-dist/legacy/build/pdf.mjs');

async function extractText() {
    const data = new Uint8Array(fs.readFileSync('d:\\Projects\\ptst\\Pandit Todarmal Smarak Trust – आधिकारिक मोबाइल ऐप.pdf'));
    const doc = await getDocument({ data }).promise;
    for (let i = 1; i <= doc.numPages; i++) {
        const page = await doc.getPage(i);
        const content = await page.getTextContent();
        const text = content.items.map(item => item.str).join(' ');
        console.log(`\n--- PAGE ${i} ---`);
        console.log(text);
    }
}

extractText().catch(console.error);
