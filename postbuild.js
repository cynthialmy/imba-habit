const fs = require("fs");
const path = require("path");

const filePath = path.join(__dirname, "dist", "index.html");

fs.readFile(filePath, "utf8", (err, data) => {
	if (err) {
		console.error("Failed reading index.html:", err);
		return;
	}

	const result = data
		.replace(/href='\/assets\//g, "href='assets/")
		.replace(/src='\/assets\//g, "src='assets/");

	fs.writeFile(filePath, result, "utf8", (err) => {
		if (err) {
			console.error("Failed writing to index.html:", err);
		}
	});
});
