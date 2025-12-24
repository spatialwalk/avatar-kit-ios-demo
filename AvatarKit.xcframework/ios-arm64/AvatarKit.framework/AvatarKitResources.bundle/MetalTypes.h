#ifndef MetalTypes_h
#define MetalTypes_h

#include <metal_stdlib>
using namespace metal;

constant const int kMaxViewCount = 2;
constant static const half kBoundsRadius = 2;
constant static const half kBoundsRadiusSquared = kBoundsRadius*kBoundsRadius;
constant static const int kSRTextureCount = 4;

enum BufferIndex: int32_t
{
    BufferIndexUniforms = 0,
    BufferIndexSplat    = 1,
    BufferIndexSplatFilterMode = 2,
};

typedef struct
{
    float2 offset;
    float scale;
    float _padding;
} BlitUniforms;

typedef struct
{
    matrix_float4x4 projectionMatrix;
    matrix_float4x4 viewMatrix;
    uint2 screenSize;
} Uniforms;

typedef struct
{
    Uniforms uniforms[kMaxViewCount];
} UniformsArray;

typedef struct
{
    float position[3];         // 12 bytes
    float color[4];            // 16 bytes (RGBA, alpha in color[3])
    float covariance[6];       // 24 bytes (covA: 0-2, covB: 3-5)
} Splat;                       // 52 bytes

#endif /* MetalTypes_h */
