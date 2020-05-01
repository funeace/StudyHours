module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'success'
    when 'error'
      'danger'
    when 'alert'
      'warning'
    when 'notice'
      'info'
    else
      flash_type.to_s
    end
  end

  def devise_error_messages
    return '' if resource.errors.empty?

    errors_html = ''
    resource.errors.full_messages.each do |err_msg|
      errors_html += <<-EOF
          <div class="alert-danger pl-3">#{err_msg}</div>
                     EOF
    end
    errors_html.html_safe
  end
end
