import std/osproc
#  Phase 3 Test 3.1: 3D Sphere Ray Tracer Benchmark in Compound

import std/math

type Vec3 = object
  x: float64
  y: float64
  z: float64

proc dot(v1: Vec3, v2: Vec3): float64 {.discardable.} =
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z

proc normalize(v: Vec3): Vec3 {.discardable.} =
  var len = sqrt(dot(v, v))
  return Vec3(x: v.x / len, y: v.y / len, z: v.z / len)

var width = 100
var height = 50

echo "P3", width, height, 255

var sphere_center = Vec3(x: 0.0, y: 0.0, z: -5.0)
var sphere_radius = 2.0
var light_dir = normalize(Vec3(x: 1.0, y: 1.0, z: -1.0))

var j = 0
while j < height:
  var i = 0
  while i < width:
    var dir_x = (float64(i) - float64(width) / 2.0) / float64(width)
    var dir_y = (float64(j) - float64(height) / 2.0) / float64(height)
    var ray_dir = normalize(Vec3(x: dir_x, y: dir_y, z: -1.0))

    var oc = Vec3(x: -sphere_center.x, y: -sphere_center.y, z: -sphere_center.z)
    var b = dot(oc, ray_dir)
    var c = dot(oc, oc) - sphere_radius * sphere_radius
    var disc = b * b - c

    if disc > 0.0:
      var t = b - sqrt(disc)
      var hit_pos = Vec3(x: ray_dir.x * t, y: ray_dir.y * t, z: ray_dir.z * t)
      var normal = normalize(Vec3(x: hit_pos.x - sphere_center.x, y: hit_pos.y - sphere_center.y, z: hit_pos.z - sphere_center.z))
      var intensity = max(0.0, dot(normal, light_dir))
      var c_val = int(intensity * 255.0)
      echo c_val, c_val, c_val
    else:
      echo 0, 0, 0

    i += 1
  j += 1
