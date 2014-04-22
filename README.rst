Commands
========

# Clone Ember website
git clone https://github.com/emberjs/website.git

# Combine Ember documentation pages into one file
ruby generate_ember_guide_pdf.rb

# Convert to HTML
pandoc --from=markdown --to=html ember_guides_combined.md --output=ember_guides_combined.html

# Convert HTML to MOBI
kindlegen ember_guides_combined.html -o ember_guides_combined.mobi

# Convert from HTML to PDF
weasyprint ember_guides_combined.html ember_guides_combined.pdf

# Convert to EPUB
pandoc --from=markdown --to=epub ember_guides_combined.md --output=ember_guides_combined.epub

TODOs
=====

- images are currently not supported at all
