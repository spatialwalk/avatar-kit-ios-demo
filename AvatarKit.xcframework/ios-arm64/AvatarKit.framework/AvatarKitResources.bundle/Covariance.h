#ifndef Covariance_h
#define Covariance_h

#include <metal_stdlib>
using namespace metal;

float3 calcCovariance2D(float3 viewPos,
                       packed_half3 cov3Da,
                       packed_half3 cov3Db,
                       float4x4 viewMatrix,
                       float4x4 projectionMatrix,
                       uint2 screenSize);

void decomposeCovariance(float3 cov2D, thread float2 &v1, thread float2 &v2);

#endif /* Covariance_h */
