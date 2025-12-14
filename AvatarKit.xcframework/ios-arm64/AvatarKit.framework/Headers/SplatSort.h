#ifndef SplatSort_h
#define SplatSort_h

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    float x, y, z;
} SplatPosition;

void sortSplatIndexes(const SplatPosition* positions,
                     uint32_t vertexCount,
                     float cameraForwardX,
                     float cameraForwardY,
                     float cameraForwardZ,
                     float cameraForwardW,
                     uint32_t* depthIndex);

#ifdef __cplusplus
}
#endif

#endif /* SplatSort_h */
