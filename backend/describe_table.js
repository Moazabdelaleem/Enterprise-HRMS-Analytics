const db = require('./config/database');
const fs = require('fs');

async function describe() {
    try {
        const [rows] = await db.query('DESCRIBE JOB_ASSIGNMENT');
        const output = rows.map(r => `${r.Field}: ${r.Type} (Null: ${r.Null})`).join('\n');
        fs.writeFileSync('schema_full.txt', output);
        console.log('Written to schema_full.txt');
    } catch (e) {
        console.error(e);
    }
    process.exit();
}

describe();
