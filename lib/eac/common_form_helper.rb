module Eac
  module CommonFormHelper
    def common_form(model_instance, options = {}, &block)
      submit_label = options.delete(:submit_label)
      form_for(model_instance, options) do |form|
        fb = FormBuilder.new(form, self)
        errors(model_instance) <<
          capture(fb, &block) <<
          errors_not_showed(model_instance, fb.field_errors_showed) <<
          form.submit(submit_label, class: 'btn btn-primary')
      end
    end

    private

    def errors(model_instance)
      if model_instance.errors.any?
        content_tag(:div, class: 'alert alert-danger', id: 'flash_alert') do
          'Há pendências no preenchimento do formulário.'
        end
      else
        ActiveSupport::SafeBuffer.new
      end
    end

    def errors_not_showed(model_instance, field_errors_showed)
      s = ActiveSupport::SafeBuffer.new
      model_instance.errors.each do |k, v|
        next if field_errors_showed.include?(k)
        s << content_tag(:div, "#{k}: #{v}", class: 'error')
      end
      s
    end
  end
end