        </main>
    </div>

    <!-- Admin Footer -->
    <footer class="bg-white border-t border-gray-200 py-3 px-6" style="margin-left: 250px;" aria-label="Admin footer">
        <div class="flex items-center justify-between text-sm text-gray-500">
            <div>
                <span>&copy; <?php echo date('Y'); ?> Migori County Government. All rights reserved.</span>
            </div>
            <div class="flex items-center space-x-4">
                <span>PMC Portal v2.0</span>
                <span aria-hidden="true">•</span>
                <span>Last login: <?php 
                    $current_admin = get_current_admin();
                    if ($current_admin && isset($current_admin['last_login']) && $current_admin['last_login']) {
                        echo date('M j, Y g:i A', strtotime($current_admin['last_login']));
                    } else {
                        echo 'Never';
                    }
                ?></span>
            </div>
        </div>
    </footer>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Mobile menu functionality
        const mobileMenuToggle = document.getElementById('mobile-menu-toggle');
        const mobileSidebar = document.getElementById('mobile-sidebar');
        const mobileOverlay = document.getElementById('mobile-sidebar-overlay');
        
        if (mobileMenuToggle && mobileSidebar && mobileOverlay) {
            // Open mobile sidebar
            mobileMenuToggle.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                openMobileSidebar();
            });
            
            // Close on overlay click
            mobileOverlay.addEventListener('click', function() {
                closeMobileSidebar();
            });
            
            // Close on escape key
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    closeMobileSidebar();
                }
            });
            
            // Close when clicking sidebar links (for navigation)
            const mobileNavLinks = mobileSidebar.querySelectorAll('.sidebar-nav-item');
            mobileNavLinks.forEach(function(link) {
                link.addEventListener('click', function() {
                    closeMobileSidebar();
                });
            });
            
            // Prevent sidebar clicks from closing the sidebar
            mobileSidebar.addEventListener('click', function(e) {
                e.stopPropagation();
            });
        }
        
        function openMobileSidebar() {
            mobileSidebar.classList.add('active');
            mobileOverlay.classList.add('active');
            document.body.classList.add('sidebar-open');
        }
        
        function closeMobileSidebar() {
            mobileSidebar.classList.remove('active');
            mobileOverlay.classList.remove('active');
            document.body.classList.remove('sidebar-open');
        }
        
        // Auto-refresh stats if on dashboard
        if (typeof updateStats === 'function') {
            setInterval(updateStats, 30000);
            updateStats(); // Initial load
        }
        
        // Footer responsive adjustment
        function adjustFooter() {
            const footer = document.querySelector('footer[aria-label="Admin footer"]');
            if (footer) {
                if (window.innerWidth >= 1024) {
                    footer.style.marginLeft = '250px';
                } else {
                    footer.style.marginLeft = '0';
                }
            }
        }
        
        // Adjust footer on load and resize
        adjustFooter();
        window.addEventListener('resize', adjustFooter);
    });

    async function updateStats() {
        try {
            const response = await fetch('ajax/getDashboardStats.php');
            if (!response.ok) throw new Error('Network response was not ok');
            const data = await response.json();
            
            // Update stats if elements exist
            const stats = {
                'totalProjects': data.totalProjects || 0,
                'activeProjects': data.activeProjects || 0,
                'completedProjects': data.completedProjects || 0,
                'pendingFeedback': data.pendingFeedback || 0
            };
            
            Object.entries(stats).forEach(([id, value]) => {
                const element = document.getElementById(id);
                if (element) element.textContent = value;
            });
        } catch (error) {
            console.error('Error updating stats:', error);
        }
    }
    </script>

    <style>
    /* Additional responsive footer styles */
    @media (max-width: 1023px) {
        footer[aria-label="Admin footer"] {
            margin-left: 0 !important;
        }
    }
    </style>

    <?php if (!empty($additional_js) && is_array($additional_js)): ?>
        <?php foreach ($additional_js as $js_file): ?>
            <script src="<?php echo htmlspecialchars($js_file, ENT_QUOTES); ?>" defer></script>
        <?php endforeach; ?>
    <?php endif; ?>

    <script src="<?php echo htmlspecialchars(BASE_URL, ENT_QUOTES); ?>assets/js/main.js" defer></script>
</body>
</html>