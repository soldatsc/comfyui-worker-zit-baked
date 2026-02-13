FROM runpod/worker-comfyui:5.7.1-base

# Install custom nodes
RUN comfy-node-install \
    rgthree-comfy \
    comfyui-easy-use \
    comfyui-custom-scripts \
    comfyui-detail-daemon

# Download public models
RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors \
    --relative-path models/vae \
    --filename ae.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors \
    --relative-path models/clip/ZIT \
    --filename qwen_3_4b.safetensors

# Download private UNET model
ARG HF_TOKEN
RUN mkdir -p /comfyui/models/unet && \
    wget --header="Authorization: Bearer ${HF_TOKEN}" \
    -O /comfyui/models/unet/2602_ZIT_BSY_fp8_scaled-c63.safetensors \
    "https://huggingface.co/soldatsc/zit-bsy-model/resolve/main/2602_ZIT_BSY_fp8_scaled-c63.safetensors"
