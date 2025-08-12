; extends

(field
  name: (_) @key.inner
  value: [
          (string
           (string_content) @value.inner)
          (function_definition
            body: (_) @value.inner)
          (table_constructor) @value.inner
          (function_call) @value.inner
          (number) @value.inner
          (true) @value.inner
          (false) @value.inner
          (nil) @value.inner
          ] @value.outer) @key.outer
