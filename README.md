# XpliqueDemonstration

This project demonstrates Explainable AI with a pretrained **AlexNet** image classifier and the [Xplique](https://github.com/deel-ai/xplique) Python library.

The notebook:

1. Loads AlexNet with ImageNet weights.
2. Downloads and displays an example image.
3. Computes the model's top five ImageNet predictions.
4. Uses Xplique's PyTorch `TorchWrapper` and **Integrated Gradients** to estimate which pixels influenced the top prediction.
5. Displays the attribution as a heatmap and overlays it on the image.
6. Uses Xplique's **Deletion** metric to evaluate whether the highlighted pixels are important to the model.

The notebook uses Integrated Gradients because Xplique's current PyTorch wrapper supports it. Grad-CAM is available in Xplique for TensorFlow models but is not currently supported through the PyTorch wrapper.

## Requirements

- Python 3.12 or newer
- Internet access for downloading Python packages, the AlexNet weights, and the example image
- About 3 GB of disk space for the CPU-based PyTorch and TensorFlow dependencies

The included environment uses CPU-only PyTorch. A GPU is not required.

## Setup

From the project directory, create and activate a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Install JupyterLab and the notebook dependencies. The commands below intentionally install CPU-only PyTorch and install Xplique without its default CUDA/TensorFlow extras; the CPU TensorFlow runtime is then added explicitly because Xplique imports TensorFlow components at startup.

```bash
python -m pip install --upgrade pip

python -m pip install --index-url https://download.pytorch.org/whl/cpu \
  torch torchvision

python -m pip install xplique --no-deps
python -m pip install \
  tensorflow-cpu==2.20.0 \
  tensorflow-probability==0.25.0 \
  tf-keras==2.20.1 \
  decorator==5.3.1 \
  dm-tree==0.1.10 \
  deprecated einops opencv-python \
  scikit-image==0.25.2 \
  scikit-learn==1.7.2 \
  scipy==1.15.3 \
  ruff matplotlib requests

python -m pip install jupyterlab ipykernel
python -m ipykernel install --sys-prefix \
  --name xplique-experimentation \
  --display-name "Python (XpliqueExperimentation)"
```

## Run the notebook

Use the included launcher so JupyterLab uses the project-local executable and sees the correct kernel:

```bash
./start_jupyter.sh
```

Open `xplique_alexnet_explainability.ipynb` and select the kernel **Python (XpliqueExperimentation)** if it is not selected automatically.

To verify the kernel, run:

```python
import sys
print(sys.executable)
```

The printed path should end with:

```text
.venv/bin/python
```

Run the notebook cells from top to bottom. The first model-loading run downloads AlexNet's pretrained weights.

## Using another image

Replace the `image_url` value in the image-loading cell with a direct URL to an image. The model expects an RGB image and applies the preprocessing associated with the ImageNet AlexNet weights.

## Repository contents

- `xplique_alexnet_explainability.ipynb` — the demonstration notebook
- `start_jupyter.sh` — launches the project-local JupyterLab and exposes the project kernel
- `.gitignore` — excludes the local virtual environment and notebook checkpoints
