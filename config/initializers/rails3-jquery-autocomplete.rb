Rails3JQueryAutocomplete::ClassMethods.module_eval do
  def autocomplete(name, targets, options = {})
    define_method("autocomplete_#{name}") do
      term = params[:term]

      items = []

      if term && !term.empty?
        targets.each do |object, methods|
          methods.each do |method|
            items += ( get_items(:model => get_object( object ), \
            :options => options, :term => term, :method => method ) )
          end
        end
      else
        items = []
      end
      render :json => json_for_autocomplete(items.uniq, targets, options[:display_value] ||= method)
    end
  end
end

Rails3JQueryAutocomplete::Helpers.module_eval do
  def json_for_autocomplete(items, targets, method)
    items.collect {|item| {"id" => item.id, "label" => item.send(method), "value" => item.send(method)}}
  end

  def get_autocomplete_items(parameters)
    model = parameters[:model]
    method = parameters[:method]
    options = parameters[:options]
    term = parameters[:term]
    is_full_search = options[:full]
    where_filter = options[:where_filter]

    limit = get_autocomplete_limit(options)
    implementation = get_implementation(model)
    order = get_autocomplete_order(implementation, method, options)

    case implementation
      when :mongoid
        search = (is_full_search ? '.*' : '^') + term + '.*'
        items = model.where(method.to_sym => /#{search}/i).limit(limit).order_by(order)
      when :activerecord
        items = model.where([((where_filter != nil) ? (where_filter + " AND ") : "") + "LOWER(#{method}) LIKE ?", "#{(is_full_search ? '%' : '')}#{term.downcase}%"]) \
          .limit(limit).order(order)
    end
  end
end