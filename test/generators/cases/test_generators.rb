# frozen_string_literal: true

require 'base_helper'

require 'rails/generators/test_case'
require 'client_side_validations/simple_form'
require 'generators/client_side_validations/copy_assets_generator'
require 'generators/client_side_validations/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests ClientSideValidations::Generators::InstallGenerator
  destination File.expand_path('../tmp', __dir__)
  setup :prepare_destination

  test 'Assert file is properly created when no asset pipeline present' do
    stub_configuration
    run_generator
    assert_file 'public/javascripts/rails.validations.simple_form.js'
  end

  test 'Assert file is properly created when asset pipeline present and disabled' do
    stub_configuration
    configuration = {}
    configuration.stubs(:prefix).returns('/assets')
    ClientSideValidations::Generators::CopyAssetsGenerator.stubs(:asset_pipeline_enabled?).returns false
    Rails.configuration.stubs(:assets).returns(configuration)
    run_generator
    assert_file 'public/javascripts/rails.validations.simple_form.js'
    assert_file 'public/javascripts/rails.validations.simple_form.bootstrap4.js'
  end

  test 'Assert file is not created when asset pipeline present and enabled' do
    stub_configuration
    configuration = {}
    configuration.stubs(:prefix).returns('/assets')
    ClientSideValidations::Generators::CopyAssetsGenerator.stubs(:asset_pipeline_enabled?).returns true
    Rails.configuration.stubs(:assets).returns(configuration)
    run_generator
    assert_no_file 'app/assets/javascripts/rails.validations.simple_form.js'
    assert_no_file 'app/assets/javascripts/rails.validations.simple_form.bootstrap4.js'
  end

  def stub_configuration
    Rails.stubs(:configuration).returns(mock('Configuration'))
  end
end

class CopyAssetsGeneratorTest < Rails::Generators::TestCase
  tests ClientSideValidations::Generators::CopyAssetsGenerator
  destination File.expand_path('../tmp', __dir__)
  setup :prepare_destination

  test 'Assert file is properly created when no asset pipeline present' do
    stub_configuration
    run_generator
    assert_file 'public/javascripts/rails.validations.simple_form.js'
    assert_file 'public/javascripts/rails.validations.simple_form.bootstrap4.js'
  end

  test 'Assert file is properly created when asset pipeline present and disabled' do
    stub_configuration
    configuration = {}
    configuration.stubs(:prefix).returns('/assets')
    ClientSideValidations::Generators::CopyAssetsGenerator.stubs(:asset_pipeline_enabled?).returns false
    Rails.configuration.stubs(:assets).returns(configuration)
    run_generator
    assert_file 'public/javascripts/rails.validations.simple_form.js'
    assert_file 'public/javascripts/rails.validations.simple_form.bootstrap4.js'
  end

  test 'Assert file is properly created when asset pipeline present and enabled' do
    stub_configuration
    configuration = {}
    configuration.stubs(:prefix).returns('/assets')
    ClientSideValidations::Generators::CopyAssetsGenerator.stubs(:asset_pipeline_enabled?).returns true
    Rails.configuration.stubs(:assets).returns(configuration)
    run_generator
    assert_file 'app/assets/javascripts/rails.validations.simple_form.js'
    assert_file 'app/assets/javascripts/rails.validations.simple_form.bootstrap4.js'
  end

  def stub_configuration
    Rails.stubs(:configuration).returns(mock('Configuration'))
  end
end
