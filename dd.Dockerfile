ARG BUILDER_IMAGE

FROM ${BUILDER_IMAGE} AS build

WORKDIR /build
COPY . .

RUN make build

FROM registry.ddbuild.io/images/nvidia-cuda-base:12.9.0

LABEL maintainers="Compute"

COPY --from=build /build/nvidia-kubevirt-gpu-device-plugin /usr/bin/
COPY --from=build /build/utils/pci.ids /usr/pci.ids

CMD ["nvidia-kubevirt-gpu-device-plugin"]
