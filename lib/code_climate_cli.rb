require 'mkmf'

module CodeClimateCli
  def self.available?
    find_executable('docker') &&
      system('docker image inspect codeclimate/codeclimate', out: File::NULL)
  end

  def self.run(command)
    system(<<~SHELL)
      docker run \
        --interactive --tty --rm \
        --env CODECLIMATE_CODE="$PWD" \
        --volume "$PWD":/code \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume /tmp/cc:/tmp/cc \
        codeclimate/codeclimate #{command}
    SHELL
  end

  # rubocop:disable Rails/Output
  def self.give_install_instructions
    puts <<~TEXT
      A local CodeClimate analysis wasn't performed because the docker image
      wasn't available. Instructions for installing CodeClimate CLI can be
      found here:

        https://github.com/codeclimate/codeclimate

    TEXT
  end
  # rubocop:enable Rails/Output
end
