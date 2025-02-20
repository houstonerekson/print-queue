module ApplicationHelper

    def bootstrap_class_for(flash_type)
      case flash_type.to_sym
      when :notice then "success"  # Green success message
      when :alert then "warning"   # Yellow warning message
      when :error then "danger"    # Red error message
      else "info"                  # Blue info message
      end
    end

    def bootstrap_class_name_for(status)
      status_classes = {
        "pending" => "warning",
        "complete" => "success",
        "printing" => "info",
        "failed" => "danger"
      }
      status_classes[status] || "secondary"  # Default to bg-light if status is not found
    end
      
end