def deep_copy(object)
  Marshal.load(Marshal.dump(object))
end
