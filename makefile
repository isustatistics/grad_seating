clean:
	rm outputs/*.svg

compile:
	mkdir --parents outputs
	python code/pod-charts.py
