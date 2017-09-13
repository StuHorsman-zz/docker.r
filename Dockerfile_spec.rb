require "serverspec"
require "docker"

describe "Dockerfile" do
  image = Docker::Image.build_from_dir('.')

  set :os, family: :debian
  set :backend, :docker
  set :docker_image, image.id

  it "installs the right version of R" do
    expect(r_version).to include("3.4.1")
  end

  def r_version
    command("R --version").stdout
  end
end
