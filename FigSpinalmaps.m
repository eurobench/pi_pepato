classdef FigSpinalmaps < handle
    
    properties
        handle_obj;
        
        motorpools_activation; 
        motorpools_activation_avg;
        
        fig_list;
    end    
    
    
    methods
        
        function obj = FigSpinalmaps(handle_obj, motorpools_activation, motorpools_activation_avg)
            obj.handle_obj = handle_obj;
            obj.motorpools_activation = motorpools_activation;
            obj.motorpools_activation_avg = motorpools_activation_avg;
            
            obj.fig_list = uicontrol(obj.handle_obj, 'Style', 'ListBox', 'String', {'smoothed', 'raw'}, 'Value', 1, 'Units', 'normal', 'Position', [.15, .02, .08, .06]);
            obj.fig_list.Callback = @obj.fig_list_selection;
            
            obj.draw_avg_activation()
            obj.draw_smoothed_map()
            obj.link_axes()
        end
        
        
        function draw_avg_activation(obj)
            axes('Parent', obj.handle_obj);
            
            subplot('Position', [.15 .55 .7, .35]);
            for j = 1:6
                plot(obj.motorpools_activation_avg(7-j, :), 'Tag', ['mp_activation_' num2str(j)]); hold on;
            end
            legend({'L2' 'L3' 'L4' 'L5' 'S1' 'S2'});
            set(gca, 'XTick', 0:40:200); 
            set(gca, 'XTickLabel', 0:20:100);
            xlim([1 200]);
            ylabel('Relative power of MP activation');
        end
        
        
        function draw_raw_map(obj)
            axes('Parent', obj.handle_obj);
            
            subplot('Position', [.15 .1 .7, .35]);
            contourf(obj.motorpools_activation, 30, 'LineStyle', 'none', 'Tag', 'mp_contour_raw');
            c2max = max(max(obj.motorpools_activation));
            caxis([0 c2max]);   
            set(gca, 'YTick', 3.5:6:33.5); 
            set(gca, 'YTickLabel', {'S2' 'S1' 'L5' 'L4' 'L3' 'L2'});
            set(gca, 'XTick', 0:40:200); 
            set(gca, 'XTickLabel', 0:20:100);
            ylabel('Spinal cord segments');
            xlabel('percent of movement cycle');
            xlim([1 200]);
        end
        
        
        function draw_smoothed_map(obj)
            axes('Parent', obj.handle_obj);
            
            subplot('Position', [.15 .1 .7, .35]);
            contourf(obj.motorpools_activation_avg, 30, 'LineStyle', 'none', 'Tag', 'mp_contour_smooth'); 
            c2max = max(max(obj.motorpools_activation_avg));
            caxis([0 c2max]);   
            set(gca, 'YTick', 1:6); 
            set(gca, 'YTickLabel', {'S2' 'S1' 'L5' 'L4' 'L3' 'L2'});
            set(gca, 'XTick', 0:40:200); 
            set(gca, 'XTickLabel', 0:20:100);
            ylabel('Spinal cord segments');
            xlabel('percent of movement cycle');
            xlim([1 200]);
        end
        
        
        function link_axes(obj)
            linkaxes(find_axes_by_plot(obj.handle_obj, 'mp_*'), 'x'); % linking of subplot axes for X-axis
        end
        
        
        function fig_list_selection(obj, ~, ~)
            selected = get(obj.fig_list, 'Value');
            selected = obj.fig_list.String{selected};
            
            eval(sprintf('obj.draw_%s_map()', selected))
            obj.link_axes()
        end
        
    end
    
end
