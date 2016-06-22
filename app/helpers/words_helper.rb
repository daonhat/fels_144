module WordsHelper
  def add_answer_link name, association, target
    content_tag :spam, "<a>#{name}</a>".html_safe,
      class: "add_answer",
      "data-association": association,
      target: target
  end

  def new_fields_template f, association, options={}
    options[:object] ||= f.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize + "_fields"
    options[:template] ||= association.to_s + "_fields"
    options[:f] ||= :f

    tmpl = content_tag :div, id:"#{options[:template]}" do
      tmpl = f.fields_for association, options[:object], child_index: "new_#{association}" do |b|
        render partial: options[:partial], locals: {f: b}
      end
    end
    tmpl = tmpl.gsub /(?<!\n)\n(?!\n)/, " "
    "<script> var #{options[:template]} = '#{tmpl.to_s}' </script>".html_safe
	end

  def word_answer_class word_answer
    word_answer.is_correct? ? "correct_answer" : "well"
  end
end
