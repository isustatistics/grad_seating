clean:
	rm -f outputs/*.svg
	rm -f outputs/*.pdf

compile:
	mkdir --parents outputs
	python code/pod-charts.py
	bash code/convert-to-pdf.sh
