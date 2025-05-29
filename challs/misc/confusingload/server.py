from flask import Flask, send_file, render_template_string
import os
import random

app = Flask(__name__)
fragments_dir = "fragments"
fragment_files = os.listdir(fragments_dir)

HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>Cloud anti-bloatware</title>
</head>
<body>
    <h1>Cloud anti-bloatware</h1>
    <h2>Per questioni di leggerezza, i file possono pesare massimo 26KB<h2>
    <p>flag.png: {{ original_size }}B diviso in {{ count }} frammenti</p>
    <ul>
        {% for file in fragments %}
        <li><a href="/fragments/{{ file }}">{{ file }}</a></li>
        {% endfor %}
    </ul>
</body>
</html>
"""


@app.route("/")
def index():
    with open("flag.png", "rb") as f:
        original_size = len(f.read())

    shuffled = random.sample(fragment_files, len(fragment_files))
    return render_template_string(
        HTML, fragments=shuffled, count=len(fragment_files), original_size=original_size
    )


@app.route("/fragments/<filename>")
def serve_fragment(filename):
    return send_file(os.path.join(fragments_dir, filename))


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
