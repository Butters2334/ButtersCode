Pod::Spec.new do |spec|
  spec.name         = "ButtersCode"
  spec.version      = "0.0.1"
  spec.summary      = "只是马先生写的无聊代码"
  spec.description  = <<-DESC
  没什么需要说明的
                   DESC

  spec.homepage     = "https://github.com/Butters2334/ButtersCode"
  spec.license      = "MIT"
  spec.author             = { "butters" => "mhk466@163.com" }
  spec.source       = { :git => "https://github.com/Butters2334/ButtersCode.git",}
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"
  # spec.dependency "JSONKit", "~> 1.4"
end
